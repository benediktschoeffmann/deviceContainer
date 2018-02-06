<?

// https://code.jquery.com/

// The integrity and crossorigin attributes are used for Subresource Integrity (SRI)
// checking (https://www.w3.org/TR/SRI/). This allows browsers to ensure that resources
// hosted on third-party servers have not been tampered with. Use of SRI is recommended
// as a best-practice, whenever libraries are loaded from a third-party source.
// Read more at srihash.org (https://www.srihash.org/)

// $jqueryMajorVersion = 1;
// $jqueryMajorVersion = 2;
$jqueryMajorVersion = 3;

$jqueryVariant = 'dev';
// $jqueryVariant = 'prod';

?>

<? if (1 == $jqueryMajorVersion && 'dev' == $jqueryVariant): ?>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script>//if (!window.jQuery) { document.write('<script src="/path/to/your/jquery"><\/script>'); }</script>
<? endif; ?>

<? if (1 == $jqueryMajorVersion && 'prod' == $jqueryVariant): ?>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<? endif; ?>

<? if (2 == $jqueryMajorVersion && 'dev' == $jqueryVariant): ?>
<script src="https://code.jquery.com/jquery-2.2.4.js" integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI=" crossorigin="anonymous"></script>
<? endif; ?>

<? if (2 == $jqueryMajorVersion && 'prod' == $jqueryVariant): ?>
<script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<? endif; ?>

<? if (3 == $jqueryMajorVersion && 'dev' == $jqueryVariant): ?>
<script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
<? endif; ?>

<? if (3 == $jqueryMajorVersion && 'prod' == $jqueryVariant): ?>
<script src="https://code.jquery.com/jquery-3.0.0.min.js" integrity="sha256-JmvOoLtYsmqlsWxa7mDSLMwa6dZ9rrIdtrrVYRnDRH0=" crossorigin="anonymous"></script>
<? endif; ?>
