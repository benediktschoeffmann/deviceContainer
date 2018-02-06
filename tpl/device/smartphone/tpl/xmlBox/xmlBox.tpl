<?
/**
 * xml box
 * @var channel oe24.core.Channel
 * @var box oe24.core.XmlBox
 */


return;


// $boxType = $box->_getType()->getName();
// error('Der BoxType `'.$boxType.'` ist nicht implementiert');
// return;

// -------------------------------------------

$templateOptions = $box->getTemplateOptions();
// debug($templateOptions);

?>
<div class="xmlBox">
    <? if (0): ?>
        <p><?= __FILE__; ?></p>
        <p><?= var_export($templateOptions, true); ?></p>
    <? endif; ?>
</div>
