<?
/**
 * override slideshow voting 3-2-1 modal
 * @var modalData array<any>
 */
?>

<? if (1): ?>

<div class="modalContainer">

    <div class="modalContent">

        <? if (isset($modalData['overlayHeadline'])): ?>
            <h2><?= $modalData['overlayHeadline']; ?></h2>
        <? endif; ?>

        <p>Durch Drücken auf den grünen 'Abschicken'-Button wird Ihre Auswahl gesendet.</p>

        <? if (isset($modalData['overlayText']) && false == empty($modalData['overlayText'])): ?>

            <? if (isset($modalData['showCompetiton']) && false == $modalData['showCompetiton']): ?>

                <p><?= $modalData['overlayText']; ?></p>

                <div class="modalData" id="modalData">

                    <input class="modalDataName"    type="text"  value="<?= $modalData['valueName']; ?>"    name="modalDataName"    maxlength="30" placeholder="Name">
                    <input class="modalDataTelefon" type="tel"   value="<?= $modalData['valueTelefon']; ?>" name="modalDataTelefon" maxlength="30" placeholder="Telefonnummer">
                    <input class="modalDataEmail"   type="email" value="<?= $modalData['valueEmail']; ?>"   name="modalDataEmail"   maxlength="30" placeholder="E-Mail Adresse">

                </div>

            <? endif; ?>

        <? endif; ?>

        <div class="modalButtons clearfix">
            <button class="modalButtonCancel" type="button">Schließen</button>
            <button class="modalButtonSubmit" type="button">Abschicken</button>
        </div>

        <p class="modalContentThanks">Vielen Dank für's Mitmachen!</p>

    </div>

</div>

<? endif; ?>
