export class User {
  id: number;
  username: string;
  password: string;
  role: string;
  enabled: boolean;
  firstName: string;
  lastName: string;
  profileImageUrl: string | null;
  aboutMe: string | null;

  constructor(
    id: number = 0,
    username: string = '',
    password: string = '',
    role: string = '',
    enabled: boolean = true,
    firstName: string = "",
    lastName: string = "",
    profileImageUrl: string | null = null,
    aboutMe: string | null = null,
  ) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.role = role;
    this.enabled = enabled;
    this.firstName = firstName;
    this.lastName = lastName;
    this.profileImageUrl = profileImageUrl;
    this.aboutMe = aboutMe;
  }
}
