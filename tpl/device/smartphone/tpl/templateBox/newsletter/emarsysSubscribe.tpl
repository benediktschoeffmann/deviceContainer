<?
/**
 * template box
 */


if (request()->getGetValue('email') || request()->getGetValue('nl')) {
	
	$newsletter = ( request()->getGetValue('nl') ) ? request()->getGetValue('nl') : 'oe24';
	$emailreq = ( request()->getGetValue('em') ) ? request()->getGetValue('em') : '0';
	$codereq = ( request()->getGetValue('co') ) ? request()->getGetValue('co') : '0';

	$oNewsletterApi = Oe24NewsletterApi::getInstance();

	$oNewsletterApi->registerUser($newsletter, $emailreq, $codereq);

}

?>

