<?php

$structure = new ArticleStructureNodeList();

$structure->addNode(new ArticleStructureNode(
        'page.header',
        array(
            'layoutOverride',
            'dayOfWeek',
        )
    )
);

$structure->addNode(new ArticleStructureNode(
        'page.body',
        array(
            'bodyText',
        )
    )
);

$structure->addNode(new ArticleStructureNode(
        'page.footer',
        array(
            'articleType',
            'paramStore',
        ),
        'footer fertig aufgebaut'
    )
);

$exportStructure = $structure;
