<?php
/**
 * @collector noauto
 */
?>

var emarsys = {

	register: {
		error: '',
		form_lanuage: 'de',

		onbeforesubmit: function()
		{
			return true;
		},

		is_3_valid: function(input)
		{
			if(input == "")
			{
				emarsys.register.error += "E-Mail: Eingabe fehlt!\n";
				return false;
			}

			var emailPat=/^(.+)@(.+)$/;
			var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]";
			var validChars="\[^\\s" + specialChars + "\]";
			var quotedUser="(\"[^\"]*\")";
			var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;
			var atom=validChars + '+';
			var word="(" + atom + "|" + quotedUser + ")";
			var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
			var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$");


			var matchArray=input.match(emailPat);
			if (matchArray==null) {
				emarsys.register.error += "E-Mail: Bitte geben Sie eine g\u00fcltige E-Mail Adresse an!\n"; // check @ and .
				return false;
			}
			var user=matchArray[1];
			var domain=matchArray[2];

			if (user.match(userPat)==null) {
				emarsys.register.error += "E-Mail: Bitte geben Sie eine g\u00fcltige E-Mail Adresse an!\n"; // username doesn't seem to be valid
				return false;
			}

			var IPArray=domain.match(ipDomainPat);
			if (IPArray!=null) {
				 for (var i=1;i<=4;i++) {
					 if (IPArray[i]>255) {
						emarsys.register.error += "E-Mail: Bitte geben Sie eine g\u00fcltige E-Mail Adresse an!\n"; // Destination IP address is invalid
						return false;
					 }
				 }
				 return true;
			}

			var domainArray=domain.match(domainPat);
			if (domainArray==null) {
				emarsys.register.error += "E-Mail: Bitte geben Sie eine g\u00fcltige E-Mail Adresse an!\n"; // The domain name doesn't seem to be valid
				 return false;
			}

			var atomPat=new RegExp(atom,"g");
			var domArr=domain.match(atomPat);
			var len=domArr.length;


			if (len<2) {
				emarsys.register.error += "E-Mail: Bitte geben Sie eine g\u00fcltige E-Mail Adresse an!\n"; // This address is missing a hostname
				return false;
			}

			return true;
		},

		CheckInputs: function()
		{
			var newsletterType = (typeof document.getElementById('nltype') != 'undefined') ? document.getElementById('nltype').value : 'oe24';

			var check_ok = true;
			emarsys.register.error = "Fehler in der Eingabe!\n";

			emailField = document.ProfileForm.email;
			check_ok = (emarsys.register.is_3_valid(emailField.value) && check_ok);

			if ('MediaMonitor' == newsletterType) {
				var firstName = document.ProfileForm.firstname.value;
				if (firstName.length<1){
					check_ok = false;
					emarsys.register.error += "Vorname: Eingabe fehlt!\n";
				}

				var lastName = document.ProfileForm.lastname.value;
				if (lastName.length<1){
					check_ok = false;
					emarsys.register.error += "Nachname: Eingabe fehlt!\n";
				}

				var companyName = document.ProfileForm.companyname.value;
				if (companyName.length<1){
					check_ok = false;
					emarsys.register.error += "Firmenname: Eingabe fehlt!\n";
				}
			}

			// check checkbox
			// var optIn = document.getElementById('nlOptin');
		 //    if (!optIn.checked) {
		 //    	check_ok = false;
		 //    	error += "Bitte die Allgemeinen Gesch\u00e4ftsbedingungen best\u00e4tigen!\n";
		 //    }

		 	// salutation = gender
		 	var salutation = document.getElementById('inp_46');
		 	var gender = document.getElementById('inp_5');
		 	if (salutation && gender) {
		 		gender.value = salutation.value;
		 	}


			if(check_ok == false) {
				alert(emarsys.register.error);
			}

			return check_ok;
		},

		SubmitIt: function(){
			alert("submitIt");
			if(emarsys.register.CheckInputs() == true){
                if(window.onbeforesubmit)
                                emarsys.register.onbeforesubmit();

                document.ProfileForm.submit();
            }
		},

		MailIt: function(){
			alert("mailIt");
            if(emarsys.register.CheckInputs()){
                if((document.ProfileForm.subject.value=='') || (document.ProfileForm.msg.value==''))
                	alert('Bitte f\u00fcr Sie die Nachrichtenfelder aus!');
                else
                	document.ProfileForm.submit();
		    }
		},

		FieldWithName: function(frm, fieldname, numofield)
		{
		    if(!numofield)
		        numofield = 0;
		    field_count = 0;
		    for(i = 0; i < frm.elements.length; ++i)
		    {
		        if(frm.elements[i].name == fieldname)
		        {
		            if(field_count == numofield)
		                return frm.elements[i];
		            else
		                field_count++;
		        }
		    }
		},

		NumChecked: function(frm, fieldname)
		{
			var count = 0;
			for(i = 0; i < frm.elements.length; ++i)
			{
				if(frm.elements[i].name == fieldname && frm.elements[i].checked == true)
						++count;
			}
			return count;
		},

		NumSel: function(field)
		{
		    var count = 0;
		    for(i = 0; i < field.length; ++i)
		        if(field[i].selected == true) ++count;
		    return count;
		}
	}
}

