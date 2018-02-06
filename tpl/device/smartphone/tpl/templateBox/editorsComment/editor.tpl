<?
/**
 * template box
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$validEditors = array(
    'bauernebel_herbert' => array(
        'firstname' => 'Herbert',
        'lastname'  => 'Bauernebel',
        'class'     => 'bauernebel-herbert',
    ),
    'daniel_isabelle' => array(
        'firstname' => 'Isabelle',
        'lastname'  => 'Daniel',
        'class'     => 'daniel-isabelle',
    ),
    'fellner_niki' => array(
        'firstname' => 'Niki',
        'lastname'  => 'Fellner',
        'class'     => 'fellner-niki',
        'useData'   => true,
        'href'      => 'http://www.oe24.at/newsletter/oe24-morgen',
        'preTitle'  => 'oe24-Newsletter',
        'title'     => 'Die Top-News des Tages im Überblick',
    ),
    'fellner_wolfgang' => array(
        'firstname' => 'Wolfgang',
        'lastname'  => 'Fellner',
        'class'     => 'fellner-wolfgang',
    ),
    'krankl_hans' => array(
        'firstname' => 'Hans',
        'lastname'  => 'Krankl',
        'class'     => 'krankl-hans',
    ),
    'polster_toni' => array(
        'firstname' => 'Toni',
        'lastname'  => 'Polster',
        'class'     => 'polster-toni',
    ),
    'fink_thorsten' => array(
        'firstname' => 'Thorsten',
        'lastname'  => 'Fink',
        'class'     => 'fink-thorsten',
    ),
    'hofmann_steffen' => array(
        'firstname' => 'Steffen',
        'lastname'  => 'Hofmann',
        'class'     => 'hofmann-steffen',
    ),
    'huetter_adi' => array(
        'firstname' => 'Adi',
        'lastname'  => 'Hütter',
        'class'     => 'huetter-adi',
    ),
    'linz_roland' => array(
        'firstname' => 'Roland',
        'lastname'  => 'Linz',
        'class'     => 'linz-roland',
    ),
    'klammer_franz' => array(
        'firstname' => 'Franz',
        'lastname'  => 'Klammer',
        'class'     => 'klammer-franz',
    ),
    'sykora_thomas' => array(
        'firstname' => 'Thomas',
        'lastname'  => 'Sykora',
        'class'     => 'sykora-thomas',
    ),
    'riesch_maria' => array(
        'firstname' => 'Maria',
        'lastname'  => 'Höfl-Riesch',
        'class'     => 'riesch-maria',
    ),
    'unterweger_walter' => array(
        'firstname' => 'Walter',
        'lastname'  => 'Unterweger',
        'class'     => 'unterweger-walter',
    ),
);

$defaultTopTitle = 'Kommentar';

// -------------------------------------------

$templateOptions = $box->getTemplateOptions();

// -------------------------------------------

$editors = array();

for ($i=1; $i<=6 ; $i++) {

	$redakteurUrl = trim($templateOptions->get('RedakteurIn-'.$i));
	$artikelId = trim($templateOptions->get('ArtikelID-'.$i));
	$topTitel = trim($templateOptions->get('TopTitel-'.$i));

	// nur verwenden, wenn alle ausgefüllt sind
	if (!$redakteurUrl || !$artikelId || !$topTitel) {
        continue;
    }

    // ----------------------------------------------

    // filename ermitteln
    $pathParts = pathinfo($redakteurUrl);
    $filename = $pathParts['filename'];

    if (false == array_key_exists($filename, $validEditors)) {
        continue;
    }

    // ----------------------------------------------

    $topTitle = empty($topTitel) ? $defaultTopTitle : $topTitel;
    $firstName = $validEditors[$filename]['firstname'];
    $lastName = $validEditors[$filename]['lastname'];
    $class = $validEditors[$filename]['class'];

    $useData = isset($validEditors[$filename]['useData']) ? $validEditors[$filename]['useData'] : false;

    if ($useData) {

		$href = isset($validEditors[$filename]['href']) ? $validEditors[$filename]['href'] : '#!';
		$target   = '';

		// ----------------------------------------------

    	$preTitle = isset($validEditors[$filename]['preTitle']) ? $validEditors[$filename]['preTitle'] : '&nbsp;';
    	$title = isset($validEditors[$filename]['title']) ? $validEditors[$filename]['title'] : '&nbsp;';

    	// ----------------------------------------------

    	$leadText = '';

    }
    else {

    	$story = db()->getById($artikelId, 'oe24.core.Text', false);
        if (null === $story) {
            continue;
        }

        // ----------------------------------------------

        $linkAttr = getContentUrlAttributesArray($story, $box, true, true, true);

        $href = (isset($linkAttr['href']) && is_string($linkAttr['href'])) ? $linkAttr['href'] : '#!';
        $target = (isset($linkAttr['target']) && is_string($linkAttr['target']) && '' != $linkAttr['target']) ? 'target="'.$linkAttr['target'].'"' : '';

        // ----------------------------------------------

        $preTitle = trim($story->getPreTitle(true, $box));
        $preTitle = (empty($preTitle)) ? '&nbsp;' : $preTitle;

        // ----------------------------------------------

        $title = trim($story->getTitle(true, $box)); // mergeOverride = true (Content-Overwrite-Title), $mergeBox = true (Box-Overwrite-Title)

        // Am Dev unnoetigen Titel-Prefix entfernen
        $title = str_replace(array('OEST15 - ', 'mad15 -'), '', $title);

        // ----------------------------------------------

        $leadText = trim($story->getLeadText(true, true, $box));

        // whitespace entfernen
        $leadText = preg_replace('/\s*$/iusU','',$leadText);
        $leadText = trim(str_replace(array("\n\r","\n","\r"), ' ', $leadText));

    }

    // ------------------------------------------------------------------

	$editors[] = array(
        'href'      => $href,
        'target'    => $target,
        'topTitle'  => $topTitle,
        'preTitle'  => $preTitle,
        'title'     => $title,
        'leadText'  => $leadText,
        'imageUrl'  => $redakteurUrl,
        'firstname' => $firstName,
        'lastname'  => $lastName,
        'class'     => $class,
    );

}

if (0 == count($editors)) {
	return;
}



// -------------------------------------------

$groupCellsActive = true;

$flickityOptions = array(

    'autoplay'        => false,
    'prevNextButtons' => true,
    'pageDots'        => false,
    'groupCells'      => $groupCellsActive,

    'classCounter'    => '.storiesCounter',
);

$options = json_encode($flickityOptions);

// -------------------------------------------

?>

<div class="editorsComment contentBox contentSlider console">


    <div class="flickitySlider layout_oe24" data-options='<?= $options; ?>'>

        <? foreach ($editors as $key => $editor): ?>

            <a class="story" href="<?= $editor['href']; ?>" <?= $editor['target']; ?> >

				<span class="editorsImage">
					<img src="<?= $editor['imageUrl']; ?>" data-flickity-lazyload="<?= $editor['imageUrl']; ?>" alt="">
				</span>

				<span class="editorsTop2">
					<span class="editorTextTopTitle"><?= $editor['preTitle']; ?></span>

					<span class="editorTextName"><?= $editor['firstname']; ?> <?= $editor['lastname']; ?></span>
				</span>

				<span class="editorCommentBottom"><?= $editor['title']; ?></span>

            </a>

        <? endforeach; ?>

        <div class="storiesCounter"></div>

    </div>

</div>

