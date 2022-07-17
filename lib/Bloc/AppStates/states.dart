abstract class AppStates{
}
class InitialState extends AppStates{


}

class  UploadProfileSuccessState extends AppStates{}
class  UploadProfileErrorState extends AppStates{}
class  GetProfileLoadingState extends AppStates{}

class  GetProfileSuccessState extends AppStates{}
class  GetProfileErrorState extends AppStates{}


class  UploadProfileImageSuccessState extends AppStates{}
class  UploadProfileImageErrorState extends AppStates{}

class  UploadUserProfileImageErrorState extends AppStates{}

class  UploadDiseasesSuccessState extends AppStates{}
class  UploadDiseasesErrorState extends AppStates{}

class  GetDiseasesSuccessState extends AppStates{}
class  GetDiseasesErrorState extends AppStates{}


class  GetInteractionSuccessState extends AppStates{}
class  GetInteractionErrorState extends AppStates{}