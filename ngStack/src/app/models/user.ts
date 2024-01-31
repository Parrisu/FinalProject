import { Address } from './address';
import { Technology } from "./technology";

export class User {
  id: number;
  username: string;
  password: string;
  email: string;
  role: string;
  enabled: boolean;
  firstName: string;
  lastName: string;
  profileImageUrl: string | null;
  aboutMe: string | null;
  address: Address | null;
  stack: Technology[];

  constructor(
    id: number = 0,
    username: string = '',
    password: string = '',
    email: string = '',
    role: string = '',
    enabled: boolean = true,
    firstName: string = '',
    lastName: string = '',
    profileImageUrl: string | null = null,
    aboutMe: string | null = null,
    address: Address | null = null
    stack: Technology[] = [],
  ) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.email = email;
    this.role = role;
    this.enabled = enabled;
    this.firstName = firstName;
    this.lastName = lastName;
    this.profileImageUrl = profileImageUrl;
    this.aboutMe = aboutMe;
    this.address = address;
    this.stack = stack;
  }
}
