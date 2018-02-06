<?
/**
 * header
 */

$smartphone = DeviceContainer::getDevice();

$appUrl = $smartphone->getConfig('appUrl');
$oesterreichUrl = 'http://www.österreich.at';

$layout = $smartphone->getConfig('layout');

switch ($layout) {

    case 'oe24':
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoOe24';
        $useLogoOesterreich = true;
        $headerLogoOesterreichText = 'Das Internet-Portal von';
        break;

    case 'sport':
    case 'sport24':
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoSport24';
        $useLogoOesterreich = true;
        $headerLogoOesterreichText = 'Das Sport-Portal von';
        break;

    case 'society':
    case 'stars24':
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoStars24';
        $useLogoOesterreich = true;
        $headerLogoOesterreichText = 'Das Society-Portal von';
        break;

    case 'tv':
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoOe24tv';
        $useLogoOesterreich = true;
        $headerLogoOesterreichText = 'Das Fernseh-Portal von';
        break;

    case 'radiooe24':
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoOe24radio';
        $useLogoOesterreich = true;
        $headerLogoOesterreichText = 'Der Radio-Sender von';
        break;

    case 'madonna':
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoMadonna24';
        $useLogoOesterreich = false;
        $headerLogoOesterreichText = 'Das Frauen-Portal von';
        break;

    case 'money':
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoMoney';
        $useLogoOesterreich = false;
        $headerLogoOesterreichText = 'Das Wirtschafts-Portal von';
        break;

    case 'business':
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoBusiness';
        $useLogoOesterreich = false;
        $headerLogoOesterreichText = 'Das Wirtschafts-Portal von';
        break;

    case 'reise':
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoJoe24';
        $useLogoOesterreich = false;
        $headerLogoOesterreichText = 'Das Reise-Portal von';
        break;

    case 'gesund24':
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoGesund24';
        $useLogoOesterreich = false;
        $headerLogoOesterreichText = 'Das Gesundheits-Portal von';
        break;

    case 'cooking24':
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoCooking24';
        $useLogoOesterreich = false;
        $headerLogoOesterreichText = 'Das Koch-Portal von';
        break;

    case 'games24':
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoGames24';
        $useLogoOesterreich = false;
        $headerLogoOesterreichText = 'Das Gaming-Portal von';
        break;

    default:
        $logoTemplate = 'oe24.oe24.device.smartphone.tpl._header.logo.logoOe24';
        $useLogoOesterreich = true;
        $headerLogoOesterreichText = 'Das Internet-Portal von';
        break;
}

?>

<script>
// (db) 2017-06-14 navigation: remember click before js has been loaded
var oe24_navHeaderStartLoadCheckStarted = null;
function oe24_navHeaderStartLoadCheck(){
    if(null == oe24_navHeaderStartLoadCheckStarted){
        oe24_navHeaderStartLoadCheckStarted = true;
    }
}
</script>
<? if (1): ?>
<div class="headerNavButton" onclick="oe24_navHeaderStartLoadCheck();">
    <a href="#">
        <? if (1): ?>
        <svg viewBox="0 0 30 30">
            <path d="M0,5 30,5"   stroke-width="4" />
            <path d="M0,14 30,14" stroke-width="4" />
            <path d="M0,23 30,23" stroke-width="4" />
        </svg>
        <svg viewBox="0 0 30 30">
            <path d="M4,4 L26,26" stroke-width="4" />
            <path d="M4,26 L26,4" stroke-width="4" />
        </svg>
        <? endif; ?>
    </a>
</div>
<? endif; ?>

<? if (1): ?>
<div class="headerLogoPortal">
    <a href="<?= $appUrl; ?>">
        <? tpl($logoTemplate, array()); ?>
    </a>
</div>
<? endif; ?>


<? if ($useLogoOesterreich): ?>
<div class="headerLogoOesterreich">
    <a href="<?= $oesterreichUrl; ?>">
        <span><?= $headerLogoOesterreichText; ?></span>
        <? tpl('oe24.oe24.device.smartphone.tpl._header.logo.logoOesterreich', array()); ?>
    </a>
</div>
<? endif; ?>

