<?
/**
 * test references
 * @var bodyText string
 * @var object any
 */

debug('test.tpl \\n\\n');

debug($object);

$object->push('noch was', true);
$object->push('test', 'anderer wert');

debug($object);

debug('leaving test.tpl \\n \\n');
