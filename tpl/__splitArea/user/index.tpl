<?
/**
 * Login / Registration / Lost Password Form
 *
 * @var messages array<array<string>>
 * @var forms array<spunQ.html.form.Form>
 * @var channel oe24.core.Channel
 * @cache 360d
 * @cache.dependency user
 */

# Login Form

?>

<div class="row">
    <div class="content">

        <div class="headline">
            <span class="title">Loggen Sie sich ein</span>
        </div>

        <form <? $forms["login"]->showFormAttributes() ?> class="userForm">
            <?if(isset($_GET["loginFailed"])){?>
                <div class="messages">
                    <?
                    if($_GET["loginFailed"] == "wrongData"){
                        echo "Benutzername und/oder Passwort falsch";
                    }
                    if($_GET["loginFailed"] == "activation"){
                        echo "Sich müssen Ihren Account zuerst aktivieren. Öffnen Sie dazu ihr Emailpostfach.";
                    }
                    ?>
                </div>
            <?}?>
            <table align="center" width="100%" cellpadding="2" cellspacing="0">
                <tr>
                    <td width="50%">Benutzername <font color="red">*</font></td>
                    <td><? $forms["login"]->getField("username")->show(NULL, array("middle"))?><br/>
                    <a class="user_pass_lost" href="#lostU">Benutzername vergessen?</a>
                    </td>
                </tr>
                <tr>
                    <td>Passwort <font color="red">*</font></td>
                    <td><? $forms["login"]->getField("password")->show(NULL, array("middle"))?><br/>
                    <a class="user_pass_lost" href="#lostPass">Passwort vergessen?</a></td>
                </tr>
                <tr>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                    <input type="submit" name="login" value="Jetzt einloggen"/>
                    oder
                    <img src="<?slp("image", "layout/social/fbLogin.png")?>" alt="" class="fb_button" onclick="oe24Core.popup('<?=l("oe24.oe24.user.fbConnect", array("channel" => $channel))?>', {'width':1000, 'height':500})"/>
                    </td>
                </tr>
            </table>
        </form>
        <div class="spacer"></div>
<?
# Register Form
?>


        <div class="headline">
            <span class="title">Noch nicht registriert? Jetzt registrieren!</span>
        </div>

        <form <? $forms["reg"]->showFormAttributes() ?> class="userForm">
            <?if(!empty($messages["reg"])){?>
            <div class="messages">
                <?
                foreach($messages["reg"] as $message){
                    echo "$message<br/>\n";
                }
                ?>
            </div>
            <?}?>
            <table align="center" width="100%" cellpadding="2" cellspacing="0">
                <tr>
                    <td width="50%">Benutzername <font color="red">*</font></td>
                    <td><? $forms["reg"]->getField("reg_username")->show(NULL, array("middle"))?></td>
                </tr>
                <tr>
                    <td>E-Mailadresse <font color="red">*</font></td>
                    <td><? $forms["reg"]->getField("reg_email")->show(NULL, array("middle"))?></td>
                </tr>
                <tr>
                    <td>Passwort <font color="red">*</font></td>
                    <td><? $forms["reg"]->getField("reg_password")->show(NULL, array("middle"))?></td>
                </tr>
                <tr>
                    <td>Passwort wiederholen <font color="red">*</font></td>
                    <td><? $forms["reg"]->getField("reg_password_repeat")->show(NULL, array("middle"))?></td>
                </tr>
                <tr>
                    <td colspan="2" height="30">
                    <b>AGB</b>
                    </td>
                </tr>

                <tr>
                    <td colspan="2" height="60">
                    Bitte lesen Sie unsere <a href="http://www.oe24.at/service/agb/AGB/800276" target="_blank"><u>Allgemeinen Geschäfts-Bedingungen (AGB)</u></a> und markieren Sie dann die folgende Schaltfläche.
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    <? $forms["reg"]->getField("reg_agb")->show()?> <font color="red">*</font> Ich habe die <a href="http://www.oe24.at/service/agb/AGB/800276" target="_blank"><u>AGB</u></a> gelesen und erkläre mich damit einverstanden
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    <b>Netiquette</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                   <textarea cols="45" rows="5" style="width: 95%; height:100px;">Die oe24.at Foren und Kommentarfunktionen sind allgemein zugängliche, offene und demokratische Diskursplattformen. Bitte bleiben Sie sachlich und bemühen Sie sich um eine faire und freundliche Diskussionsatmosphäre.

        Die Redaktion übernimmt keinerlei Verantwortung für den Inhalt der Beiträge, behält sich aber das Recht vor, krass unsachliche, rechtswidrige oder moralisch bedenkliche Beiträge sowie Beiträge, die dem Ansehen des Mediums schaden, zu löschen und nötigenfalls User aus der Debatte auszuschließen.

        Sie als Verfasser haften für sämtliche von Ihnen veröffentlichte Beiträge selbst und können dafür auch gerichtlich zur Verantwortung gezogen werden. Beachten Sie daher bitte, dass auch die freie Meinungsäusserung im Internet den Schranken des geltenden Rechts, insbesondere des Strafgesetzbuches (üble Nachrede, Ehrenbeleidigung etc.) und des Verbotsgesetzes, unterliegt.

        Die Redaktion behält sich vor, strafrechtlich relevante Tatbestände gegebenenfalls den zuständigen Behörden zur Kenntnis zu bringen.!</textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    <? $forms["reg"]->getField("reg_netiquette")->show()?> <font color="red">*</font> Ich habe die Netiquette gelesen und erkläre mich damit einverstanden
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                    <input type="submit" name="register" value="Jetzt registrieren"/>
                    oder
                    <img src="<?slp("image", "layout/social/fbRegister.png")?>" alt="" class="fb_button" onclick="oe24Core.popup('<?=l("oe24.oe24.user.fbRegister", array("channel" => $channel))?>', {'width':1000, 'height':400})"/>
                    </td>
                </tr>
            </table>
        </form>
        <div class="spacer"></div>


<?
# Lost Password Form
?>

        <a name="lostPass"></a>

        <div class="headline">
            <span class="title">Passwort vergessen?</span>
        </div>

        <form <? $forms["lostPass"]->showFormAttributes() ?> class="userForm">
            <?if(isset($_GET["lostPassFailed"]) or isset($_GET["successLostPass"]) or isset($_GET["successLostPass2"])){?>
                <div class="messages">
                    <?
                    if(isset($_GET["lostPassFailed"]) && $_GET["lostPassFailed"] == "wrongData"){
                        echo "Benutzername und/oder E-Mail falsch";
                    }
                    if(isset($_GET["successLostPass"])){
                        echo "<font color='green'>Öffnen Sie ihr E-Mailpostfach. Eine E-Mail mit dem Passwort rücksetzen Link wurde ihnen geschickt.</font>";
                    }
                    if(isset($_GET["successLostPass2"])){
                        echo "<font color='green'>Sie erhalten in Kürze Ihr neues Passwort zugeschickt.</font>";
                    }
                    ?>
                </div>
            <?}?>
            <table align="center" width="100%" cellpadding="2" cellspacing="0">
                <tr>
                    <td colspan="2">
                    Wenn Sie Ihr Passwort vergessen haben, können Sie sich hier ein neues Passwort zusenden lassen.
                    </td>
                </tr>
                <tr>
                    <td width="50%">Benutzername <font color="red">*</font></td>
                    <td><? $forms["lostPass"]->getField("lost_username")->show(NULL, array("middle"))?></td>
                </tr>
                <tr>
                    <td width="50%">E-Mailadresse <font color="red">*</font></td>
                    <td><? $forms["lostPass"]->getField("lost_email")->show(NULL, array("middle"))?></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" name="getPass" value="Passwort anfordern"/></td>
                </tr>
            </table>
        </form>
        <div class="spacer"></div>

<?
# Lost Username Form
?>
        <a name="lostU"></a>

        <div class="headline">
            <span class="title">Benutzername vergessen?</span>
        </div>

        <form <? $forms["lostUsername"]->showFormAttributes() ?> class="userForm">
            <?if(isset($_GET["lostUsernameFailed"])){?>
                <div class="messages">
                    <?
                    if($_GET["lostUsernameFailed"] == "wrongData"){
                        echo "Kein Benutzer mit diesen Daten gefunden";
                    }
                    ?>
                </div>
            <?}?>
            <table align="center" width="100%" cellpadding="2" cellspacing="0">
                <tr>
                    <td colspan="2">
                    Falls Sie ihren Benutzername vergessen haben können sie ihn sich hier zuschicken lassen.
                    </td>
                </tr>
                <tr>
                    <td width="50%">E-Mail <font color="red">*</font></td>
                    <td><? $forms["lostUsername"]->getField("lostU_email")->show(NULL, array("middle"))?></td>
                </tr>
                <tr>
                    <td width="50%">Passwort <font color="red">*</font></td>
                    <td><? $forms["lostUsername"]->getField("lostU_pass")->show(NULL, array("middle"))?></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" name="getUsername" value="Benutzernamen anfordern"/></td>
                </tr>
            </table>
        </form>
        <div class="spacer"></div>


    </div>
    <div class="sidebar">

        <?etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array('columnName' => 'Split-Story-Teaser Area', 'channel' => $channel, 'object' => null, 'hide' => array()));?>

    </div>
</div>

<?if(isOverride("sport", $channel) || isOverride("oe24tv", $channel)){?>
    <div class="adSlot" id="Right"></div>
<?}else{?>
    <script type="text/javascript">
        <!--
        oe24RegisterAdContainer.currentPosition = "Right";
        -->
    </script>
<?}?>

<?
tpl('oe24.oe24.__splitArea.tpl.row.row_margin', array('position' => 'bottom'));
?>
