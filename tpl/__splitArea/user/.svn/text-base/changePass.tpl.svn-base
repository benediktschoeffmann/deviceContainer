<?
/**
 * User Change Password
 *
 * @var channel oe24.core.Channel
 * @var params array<any>
 */

$errorMessages = (count($params['messages']) > 0) ? $params['messages'] : null;

?>
<div class="row row_margin_top">
    <div class="row_margin_inner"></div>
</div>
<div class="row user_registration">

    <div class="row_caption">
        <div class="row_caption_body row_caption_body_noimage">
            <div class="row_caption_title">
                <h2>Passwort ändern</h2>
            </div>
        </div>
    </div>

    <div class="content">

        <? if (null !== $errorMessages): ?>
            <div class="registerErrorMessages">
                <ul>
                <? foreach($errorMessages as $errorMsg): ?>
                    <li><?= $errorMsg; ?></li>
                <? endforeach; ?>
                </ul>
            </div>
        <? endif; ?>

        <form id="userPasswordChangeForm" method="POST">
            <fieldset>
                <div class="col col1 break">
                    <label for="oldPw" class="requiredBefore">Altes Password:</label>
                    <input type="password" id="oldPw" name="oldPw" required="required"/>
                    <label for="newPw" class="requiredBefore">Neues Passwort:</label>
                    <input type="password" id="newPw" name="newPw" required="required"/>
                    <label for="newPwAgain" class="requiredBefore">Passwort wiederholen:</label>
                    <input type="password" id="newPwAgain" name="newPwAgain" required="required"/>
                </div>

                <div class="col col1 break userSubmit">
                    <input type="submit" class="button" name="changePassword" value="Passwort ändern"/>
                </div>
            </fieldset>
        </form>

    </div>

</div>