<?

// https://developers.google.com/speed/libraries/#jquery

// $jqueryMajorVersion = 1;
// $jqueryMajorVersion = 2;
$jqueryMajorVersion = 3;

$jqueryVariant = 'dev';
// $jqueryVariant = 'prod';

?>

<? if (1 == $jqueryMajorVersion && 'dev' == $jqueryVariant): ?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.js"></script>
<? endif; ?>

<? if (1 == $jqueryMajorVersion && 'prod' == $jqueryVariant): ?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<? endif; ?>

<? if (2 == $jqueryMajorVersion && 'dev' == $jqueryVariant): ?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.js"></script>
<? endif; ?>

<? if (2 == $jqueryMajorVersion && 'prod' == $jqueryVariant): ?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<? endif; ?>

<? if (3 == $jqueryMajorVersion && 'dev' == $jqueryVariant): ?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.js"></script>
<? endif; ?>

<? if (3 == $jqueryMajorVersion && 'prod' == $jqueryVariant): ?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<? endif; ?>
