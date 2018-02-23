<?
/**
 * override slideshow voting 3-2-1 hint
 * @var hintData array<any>
 */
?>

<? if (1): ?>

<div class="hintContainer">
    <div class="modalContent">
        <p class="<?= $hintData['classThanksVoted']; ?>"><?= $hintData['hintThanksVoted']; ?></p>
        <p class="<?= $hintData['classAlreadyVoted']; ?>"><?= $hintData['hintAlreadyVoted']; ?></p>
        <div class="modalButtons">
            <button class="hintButtonClose" type="button">Schließen</button>
        </div>
    </div>
</div>

<? endif; ?>
