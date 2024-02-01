import { Technology } from './technology';
import { User } from './user';

export class Nodes {
  id: number;
  name: string;
  openToPublic: boolean;
  description: string;
  imageUrl: string;
  city: string;
  stateAbbreviation: string;
  user: User;
  stack: Technology[];

  constructor(
    id: number = 0,
    name: string = '',
    openToPublic: boolean = true,
    description: string = '',
    imageUrl: string = '',
    city: string = '',
    stateAbbreviation: string = '',
    user: User = new User(),
    stack: Technology[] = []
  ) {
    this.id = id;
    this.name = name;
    this.openToPublic = openToPublic;
    this.description = description;
    this.imageUrl = imageUrl;
    this.city = city;
    this.stateAbbreviation = stateAbbreviation;
    this.user = user;
    this.stack = stack;
  }
}
