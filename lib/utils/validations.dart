String? validatePhone(String? number){

 var isValid= RegExp(r'^(09|01|9|1)(0|9|2|6|4|9|1|5|8|7)([0-9]{7})$').hasMatch(number!.trim());
if (number.isEmpty) {
    return 'this field is required';
  }
  else if (!isValid) {
    return 'invalid phone: make sure phone is 9 digits';
  }
  else {
    return null;
  }
}

String?  validateEmail(String? email){
 var isValid= RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email!);
 if (email.isEmpty) {
    return 'this field is required';
  }
  else if (!isValid) {
    return 'invalid email';
  }
  else {
    return null;
  }

}
String?  validateRequiredField(String? value){ 

  if (value!.isEmpty) {
    return 'this field is required';
  }else {
    return null;
  }
}


String?  validatePassword(String? value){ 

  if (value!.isEmpty) {
    return 'this field is required';
  }
   if (value.length<8) {
    return 'very short password';
  }
  
  else {
    return null;
  }
}

String?  validateConfirmPassword(String? value1 , String value2){ 
print(value1);
print(value2);
  if (value1!.isEmpty) {
    return 'this field is required';
  }
   else if (value1.length<8) {
    return 'very short password';
  }
   else if (value1.trim()!=value2.trim()) {
    return ' passwords not matched';
  }
  else {
    return null;
  }
}