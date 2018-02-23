<?php

class DefaultMetaComponent extends AbstractMeta implements IMeta {
    private $metaDescription = null;
    private $metaKeywords = null;
    private $metaNewsKeywords = null;
    private $favicon = null;
    private $canonicalUrl = null;
    private $robotDescription = null;
    private $openGraphTags = array();
    private $twitterTags = array();
    private $facebookAdminsOrAppId = array();
    private $articleTags = array();

    // TODO: auslagern
    private $fbPages = array(
        '143689735528',
        '319561537533',
        '220812574978371',
        '526985287389331',
        '254647118634',
        '291224890932278'
    );

    private $object;
    private $options;
    private $config;
    private $tags = null;


    public function __construct($config) {
        $this->config = &$config;
        $this->object = ($config['isArticle']) ? $config['content'] : $config['channel'];
        $this->options = $this->object->getOptions(true, true);
    }

    public function getMetaDescription() {
        if ($this->metaDescription) {
            return $this->metaDescription;
        }

        if ($this->config['isArticle']) {
            $this->object = $this->config['content'];

            $robots = $this->getRobotsDescription();
            $this->metaDescription = ($robots) ? htmlentities($robots, ENT_COMPAT) :
                                                 htmlentities($object->getLeadText(true), ENT_COMPAT);
        }
        if (!$this->metaDescription) {
            $this->metaDescription = ($this->getOptions('metaDescription'));
            if (!$this->metaDescription) {
                $metaDescription = "Österreich / oe24.at - Das Online-Portal der Tageszeitung &quot;Österreich&quot; bietet aktuelle Text-, Bild- und Video-Nachrichten, sowie Leser- und Redaktions-Blogs.";
            }
        }
    }

    public function getFacebookPages() {
        return $this->fbPages;
    }

    public function getRobotDescription() {
        if ($this->robotDescription) {
            return $this->robotDescription;
        }
        // TODO:
        // if ((preg_match('#(/print)$#', $url) == 1) || (preg_match('#(/mailto)$#', $url) == 1)) {
        //     $this->robotDescription = $this->object->getRobotsDescription();
        // } else if (preg_match('#(/articleList/)#', $url) == 1) {
        //     $this->robotDescription = 'NOINDEX, NOARCHIVE, FOLLOW';
        // } else {
            $this->robotDescription = 'noindex, nofollow';
        // }

        return $this->robotDescription;
    }


    public function getMetaKeywords() {
        if ($this->metaKeywords) {
            return $this->metaKeywords;
        }

        $tags = $this->getTags();
        $tagNames = array_map(function($t) { return $t->getName(); }, $tags);
        $this->metaKeyWords = implode(',', $tagNames);
        return $this->metaKeywords;
    }

    public function getMetaNewsKeywords() {
        if ($this->metaNewsKeywords) {
            return $this->metaNewsKeywords;
        }

        // Das ist der Title der Page -> Das, Title, Page
        $pageTitleNouns = array_filter(
            explode(" ", $this->object->getPageTitle()),
            function($a) {
                return( preg_match('/^[A-Z]{1}/', $a) );
            }
        );

        // TODO:
        // $this->metaNewsKeywords = implode(',', $this->getTags() + $pageTitleNouns);

        $this->metaNewsKeywords = $pageTitleNouns;
        return $this->metaNewsKeywords;
    }

    public function getFavicon() {
        $layoutName = $this->getOptions('layoutOverride');

        switch ($layoutName) {
            case 'oe24':
                $this->favicon = 'O24';
                break;
            case 'business' :
            case 'games24' :
                // name ist hier gleich
                $this->favicon = $layoutName;
                break;
            case 'gesund24':
            case 'madonna':
                // G24, M24
                $this->favicon = ucfirst(substr($layoutName, 0, 1)) . '24';
                break;
            case 'antenne_salzburg':
            case 'antenne_tirol':
                $this->favicon = 'Antenne';
                break;
            default:
                $this->favicon = 'O24';
                break;
        }

        return $this->favicon;
    }

    // TODO: getCanonicalUrl
    public function getCanonicalUrl() {
        return 'http://www.oe24.at';
    }

    public function getOpenGraphTags() {
        if ($this->openGraphTags) {
            return $this->openGraphTags;
        }

        $this->openGraphTags = array(
            'og:url'            =>  $this->config['channel']->getUrl(),
            'og:title'          =>  htmlentities($this->config['channel']->getSeoPageTitle(), ENT_COMPAT, 'UTF-8'),
            'og:type'           =>  'website',
            'og:description'    =>  htmlentities($this->getMetaDescription(), ENT_COMPAT, 'UTF-8'),
            // TODO:: richtiges image
            'og:image'          =>  lp('image', 'layout/social/op/oe24.png'),
        );

        return $this->openGraphTags;
    }

    public function getTwitterTags() {
        if ($this->twitterTags) {
            return $this->twitterTags;
        }

        $this->twitterTags = array(
            'twitter:card' => 'summary_large_image',
            'twitter:site' => '@oe24News',
            'twitter:creator' => '@oe24News',
            'twitter:title' => htmlentities($this->object->getPageTitle(), ENT_COMPAT, 'UTF-8'),
            # TODO:
            # 'twitter:description' => htmlentities($this->object->getLeadText(), ENT_COMPAT, 'UTF-8'),
        );

        if ($this->getOptions('isArticle')) {
            $image = $this->object->getFirstRelatedImage();
            $this->twitterTags['twitter:image'] = $image->getFileUrl('consoleMadonnaNoStretch2');
        }

        return $this->twitterTags;
    }

    public function getFacebookAdminsOrAppId() {
        if ($this->facebookAdminsOrAppId) {
            return $this->facebookAdminsOrAppId;
        }

        $fbAppId = $this->getOptions('FacebookAppId');
        if ($fbAppId) {
            $this->facebookAdminsOrAppId = array(
                'fbAppId' => $fbAppId
            );
        } else {
            $fbAdminIds = json_decode($this->getOptions('FacebookAdminIds'), true);
            $fbAdminIds = (!$fbAdminIds) ? array() : $fbAdminIds;
            $this->facebookAdminsOrAppId = array_map(function ($entry) {
                return array('fb:admins' => $entry);
            }, $fbAdminIds);
        }

        return $this->facebookAdminsOrAppId;
    }

    public function getArticleTags() {
        if ($this->articleTags) {
            return $this->articleTags;
        }

        $this->articleTags = array(
            'article:published_time' => date('o-m-d', $this->object->getFrontendDate()->getTimestamp()),
            'article:section'        => $this->getOptions('channel') ->getName()
        );

        $this->articleTags['article:tag'] = array_map(function ($entry) {
            return htmlentities($entry->getName(), ENT_COMPAT, 'UTF-8');
        }, $this->getTags());

        return $this->articleTags;
    }

    public function getHeaderHtml() {
        return $this->getOptions('headerHtml');
    }

    private function getOptions($param = null) {
        return ($param) ? $this->options->get($param) : $this->options;
    }

    private function getTags() {
        if (!$this->tags) {
            $this->tags = ($this->config['isArticle']) ? $this->object->getTags() : $this->object->getTags(true);
        }

        return $this->tags;
    }
}
