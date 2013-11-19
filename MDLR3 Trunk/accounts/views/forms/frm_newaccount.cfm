<!--- 
		Application: 	MDLR3
		Version:		3.3
		File:			frm_newaccount.cfm
		Description:	Form for creating new accounts
		History: 
		1.	9/4/2007	Nancy Bramucci	- File created
--->

<cfscript>
	VARIABLES.FormsController = APPLICATION.Injector.GetInstance("FormsController");
	StructAppend(VARIABLES, VARIABLES.FormsController.NewAccountSetup());
</cfscript>

<div class="createaccount">
	<!--- Error messages --->
	<cfscript>
		if (REQUEST.Error.DivMessage EQ True)
		{
			VARIABLES.AccountLibrary.DisplayUserErrorMessage(REQUEST.Error);
		}
	</cfscript>
	
	<!--- Required fields message --->
	<div style="padding-left:10px; padding-top:10px;">
		<h4 style="font-size: 105%; background-image: url('views/images/asterisk.gif'); background-repeat: no-repeat; background-position: left; padding: 0px 0 3px 27px;">Required fields</h4>
	</div>
	
	<!--- Form --->
	<form name="createaccount" id="createaccount" method="post" action="dsp_newaccount.cfm" autocomplete="off">
		<!--- Login/Security Information --->
		<cfoutput>
		<fieldset><legend>Login/Security Information</legend>
			<div class="notes">
				<h4 class="help">Login/Security Information</h4>
		        <p>You must use a valid email address. You will be asked to verify your email address prior to account activation. Your email address will be your username.</p>
				<p>Passwords must consist of both letters and numbers (no special characters) and be 8-10 characters in length.</p>
			</div>		
			<!--- Email / Username --->
			<div class="inputContainer">
				<label for="email">Email Address: <span class="#REQUEST.Error.UserError1.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input class="#REQUEST.Error.UserError1.InputClass#" type="text" id="email" name="email" value="#FORM.Email#" size="35" maxLength="325" autofocus />
			</div>
			<!--- Password --->
			<div class="inputContainer">
				<label for="password">Enter password: <span class="#REQUEST.Error.UserError2.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input class="#REQUEST.Error.UserError2.InputClass#" type="password" id="password" name="password" size="10" maxlength="10" value="#FORM.Password#" />
			</div>
			<!--- Confirm Password --->
			<div class="inputContainer">
				<label for="confirmpassword">Confirm password: <span class="#REQUEST.Error.UserError3.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input class="#REQUEST.Error.UserError3.InputClass#" type="password" id="confirmpassword" name="confirmpassword" size="10" maxlength="10" value="#FORM.ConfirmPassword#" />
			</div>
			<!--- Security question --->
			<div class="inputContainer">
				<label for="reminderid">Security Question: <span class="#REQUEST.Error.UserError4.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<select name="reminderid" id="reminderid" class="#REQUEST.Error.UserError4.InputClass#">
					<cfloop from="1" to="#ArrayLen(APPLICATION.arrReminders)#" index="i">
					<option value="#APPLICATION.arrReminders[i][1]#"<cfif APPLICATION.arrReminders[i][1] EQ FORM.ReminderID> selected</cfif>>#APPLICATION.arrReminders[i][2]#</option>
					</cfloop>
				</select>
			</div>
			<!--- Security answer --->
			<div class="inputContainer">
				<label for="reminderanswer">Security Answer: <span class="#REQUEST.Error.UserError5.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input class="#REQUEST.Error.UserError5.InputClass#" type="text" id="reminderanswer" name="reminderanswer" value="#FORM.ReminderAnswer#" size="35" maxlength="50" />
			</div>												
		</fieldset>
		
		<!--- Contact Information --->
		<fieldset>
			<legend>Contact Information</legend>
			<!--- Help --->
			<div class="notes" style="border:none; background-color: ##D3DCE6;">
				<h3>&nbsp;</h3>
			</div>
			<!--- First name --->
			<div class="inputContainer">
				<label for="firstname">First Name: <span class="#REQUEST.Error.UserError6.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input class="#REQUEST.Error.UserError6.InputClass#" type="text" name="firstname" id="firstname" size="25" maxlength="50" value="#FORM.FirstName#" />
			</div>
			<!--- Middle name --->
			<div class="inputContainer">
				<label for="middlename">Middle&nbsp;Name: <span class="#REQUEST.Error.UserError7.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input class="#REQUEST.Error.UserError7.InputClass#" type="text" id="middlename" name="middlename" value="#FORM.MiddleName#" size="25" maxLength="50" />
			</div>
			<!--- Last name --->
			<div class="inputContainer">
			<label for="lastname">Last Name: <span class="#REQUEST.Error.UserError8.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
			<input class="#REQUEST.Error.UserError8.InputClass#" type="text" id="lastname" name="lastname" size="25" maxLength="50" value="#FORM.LastName#" />
			</div>
			<!--- Title --->
			<div class="inputContainer">
				<label for="title">Title: &nbsp;&nbsp;&nbsp;&nbsp;</label>
				<input type="text" id="title" name="suffix" size="15" maxLength="10" value="#FORM.Suffix#" />
				<small>(Jr., Sr., III, etc.)</small>
			</div>
			<!--- AddressTypeID --->
			<div class="inputContainer">
				<label for="addresstypeid">Address Type: <span class="#REQUEST.Error.UserError9.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<cfloop collection="#APPLICATION.strAddressType#" item="Key">
					<cfscript>
						AddressTypeID = APPLICATION.strAddressType[Key].AddressTypeID;
						AddressType = APPLICATION.strAddressType[Key].AddressType;
						Checked = VARIABLES.AddressTypeID EQ FORM.AddressTypeID ? "checked" : "";
					</cfscript>
					<label style="width: auto;">
						&nbsp;<input type="radio" class="radiotype" name="addresstypeid" value="#AddressTypeID#" #Checked# />
						&nbsp;<span style="font-weight:normal; color:black;">#AddressType#</span>
					</label>
				</cfloop>
			</div>
			<!--- Company --->
			<cfset CompanyDisplay = FORM.AddressTypeID EQ "2" ? "block" : "none">
			<div class="inputContainer" id="companyContainer" style="display: #CompanyDisplay#;">
				<label for="company">Company: <span class="#REQUEST.Error.UserError10.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input class="#REQUEST.Error.UserError10.InputClass#" type="text" name="company" id="company" size="40" value="#FORM.Company#" maxlength="150" />
			</div>
			<!--- Address 1 --->
			<div class="inputContainer">
				<label for="address1">Address 1: <span class="#REQUEST.Error.UserError11.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input type="text" name="address1" id="address1" class="#REQUEST.Error.UserError11.InputClass#" value="#FORM.Address1#" size="40" maxlength="200" />
			</div>		
			<!--- Address 2 --->
			<div class="inputContainer">
				<label for="address2">Address 2: &nbsp;&nbsp;&nbsp;&nbsp;</label>
				<input type="text" id="address2" name="address2" value="#FORM.Address2#" size="40" maxlength="200" />
			</div>		
			<!--- Suite --->
			<div class="inputContainer">
				<label for="suite">Suite: &nbsp;&nbsp;&nbsp;&nbsp;</label>
				<input type="text" id="suite" name="suite" value="#FORM.Suite#" size="10" maxlength="10" />
			</div>
			<!--- City --->
			<div class="inputContainer">
				<label for="city">City: <span class="#REQUEST.Error.UserError12.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input class="#REQUEST.Error.UserError12.InputClass#" type="text" name="city" id="city" value="#FORM.City#" size="25" maxlength="50" />
			</div>
			</cfoutput>
			<!--- Country --->
			<cfoutput>
			<div class="inputContainer">
				<label for="country">Country: <span class="#REQUEST.Error.UserError13.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<select name="country" id="country" class="#REQUEST.Error.UserError13.InputClass#">
					<option value="*" selected>Select Country</option>
					<cfloop from="1" to="#ArrayLen(APPLICATION.arrCountries)#" index="i">
						<!--- Display "United States of America" option first --->
						<cfif i EQ 1>
							<cfset Country = "United States of America">
							<cfset Selected = Country EQ FORM.Country ? "selected" : "">
							<option value="#Country#" #Selected#>#Country#</option>
						</cfif>
						<cfset Country = APPLICATION.arrCountries[i][1]>
						<!--- Don't display option for "United States of America" since it's hard-coded above --->
						<cfif Country NEQ "United States of America">
							<cfset Selected = Country EQ FORM.country ? "selected" : "">
							<option value="#Country#" #Selected#>#Country#</option>
						</cfif>
					</cfloop>
				</select>
			</div>
			<!--- State --->
			<cfset StateDisplay = FORM.Country EQ "United States of America" ? "block" : "none">
			<div class="inputContainer" id="stateContainer" style="display: #StateDisplay#;">
				<label for="state">State: <span class="#REQUEST.Error.UserError14.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<select name="state" id="state" class="#REQUEST.Error.UserError14.InputClass#">
					<option value="*">Select State</option>
					<cfloop from="1" to="#ArrayLen(APPLICATION.arrStates)#" index="i">
						<!--- Display "Maryland" option first --->
						<cfif i EQ 1>
							<cfset State = "Maryland">
							<cfset Selected = State EQ FORM.State ? "selected" : "">
							<option value="#State#" #selected#>#State#</option>
						</cfif>
						<cfset State = APPLICATION.arrStates[i][1]>
						<!--- Don't display option for "Maryland" since it's hard-coded above --->
						<cfif State NEQ "Maryland">
							<cfset Selected = State EQ FORM.State ? "selected" : "">
							<option value="#State#" #Selected#>#State#</option>
						</cfif>
					</cfloop>
				</select>
			</div>
			<!--- County --->
			<cfset CountyDisplay = FORM.State EQ "Maryland" ? "block" : "none">
			<div class="inputContainer" id="countyContainer" style='display: #CountyDisplay#;'>
				<label for="county">County: <span class="#REQUEST.Error.UserError15.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<select name="county" id="county" class="#REQUEST.Error.UserError15.InputClass#">
					<option value="*">Select County</option>
					<cfloop from="1" to="#ArrayLen(APPLICATION.arrCounties)#" index="i">
						<cfset selected = APPLICATION.arrCounties[i][1] eq FORM.county ? "selected" : "">
						<option value="#APPLICATION.arrCounties[i][1]#" #selected#>#APPLICATION.arrCounties[i][1]#</option>
					</cfloop>
				</select>
			</div>
			<!--- Postal Code; required - required if US --->
			<div class="inputContainer">
				<label for="zipcode">Postal Code: <span class="#REQUEST.Error.UserError29.LabelClass# requiredForUSA">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input class="#REQUEST.Error.UserError29.InputClass#" type="text" id="zipcode" name="zipcode" value="#FORM.ZipCode#" size="15" maxlength="10" />
			</div>
			<!--- Phone; required - required if US --->
			<div class="inputContainer">
				<label for="phone">Phone No.: <span class="#REQUEST.Error.UserError30.LabelClass# requiredForUSA">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input class="#REQUEST.Error.UserError30.InputClass#" type="text" id="phone" name="phone" value="#FORM.Phone#" size="15" maxlength="20" />
			</div>
			<!--- Phone extension --->
			<div class="inputContainer">
				<label for="extension">Phone Extension: <span class="#REQUEST.Error.UserError20.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input class="#REQUEST.Error.UserError20.InputClass#" type="text" id="extension" name="phoneext" value="#FORM.PhoneExt#" size="4" maxlength="4" />
			</div>
			<!--- Fax --->
			<div class="inputContainer">
				<label for="fax">Fax No.: <span class="#REQUEST.Error.UserError21.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<input class="#REQUEST.Error.UserError21.InputClass#" type="text" id="fax" name="fax" value="#FORM.Fax#" size="15" maxlength="20" />
			</div>
		</fieldset>
		
		<!--- Acceptable Use --->
		<fieldset>
			<legend>Verification</legend>
			<div class="notes">
				<h4 class="help">Verification</h4>
				<p>#GetProfileString(APPLICATION.IniFile, "Messages", "AcceptableUsePolicy")#</p>
			</div>
			<!--- Terms of Use --->
			<div class="inputContainer">
				<label for="acceptterms" style="height: 35px;">Terms of Use: <span class="#REQUEST.Error.UserError22.LabelClass#">&nbsp;&nbsp;&nbsp;&nbsp;</span></label>
				<cfscript>
					VARIABLES.Checked = FORM.AcceptTerms EQ 1 ? "checked" : "";
				</cfscript>
				<input class="radiotype" type="checkbox" id="acceptterms" name="AcceptTerms" value="1" #VARIABLES.Checked#> 
				<label style="font-weight:normal; color:black; display: inline; text-align: left; float: none;" for="acceptterms">I accept the Maryland State Archives' Acceptable Use Policy.</label><br>
			</div>
			<!--- CFFormProtect --->
			<cfinclude template="/cfformprotect/cffp.cfm" runonce="true">
			<!--- Submit --->
			<div class="inputContainer">
				<label for="submit"  style="height: 60px;">&nbsp;</label>
				<input type="submit" class="button" name="UserInformation" value="Submit" />
				<cfif REQUEST.Error.DivMessage>
					<small>Be sure that you have completed all <img src="views/images/asterisk.gif"> required fields <b>and</b> corrected all <img src="views/images/alert.gif"> marked fields before submitting your application.</small>
				<cfelse>
					<small>Be sure that you complete all required fields before submitting your application.</small>
				</cfif>
			</div>
		</fieldset>
		</cfoutput>
	</form>
</div>


