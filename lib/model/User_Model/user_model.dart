class UserModel{

  String? uId;
  String ?email;
  String ?age;
  String ?phoneNumber;
  String ?image;
  String ?fullName;
  String ?bio;


  UserModel({
    this.uId,
    this.email,
    this.age,
    this.image,
    this.phoneNumber,
    this.fullName,
    this.bio,

  });

  UserModel.formJson( Map <String , dynamic> json ){

    email=json['email'];
    uId=json['id'];
    fullName=json['name'];
    bio=json['bio'];
    image=json['image'];
    age=json['age'];
    phoneNumber=json['phone'];
  }

  Map <String,dynamic> toMap(){
    return{
      'email':email,
      'name':fullName,
      'bio':bio,
      'image':image,
      'phone':phoneNumber,
      'age':age

    };
  }

}
