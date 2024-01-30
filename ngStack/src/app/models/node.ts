export class Nodes {
  id: number;
  name: string;
  openToPublic: boolean;
  description: string;
  imageUrl: string;
  stateAbbr: string;
  city: string

  constructor(
    id: number = 0,
    name: string = '',
    openToPublic: boolean = true,
    description: string = '',
    imageUrl: string = '',
    stateAbbr: string = '',
    city: string = ''
  ) {
    this.id = id;
    this.name = name;
    this.openToPublic = openToPublic;
    this.description = description;
    this.imageUrl = imageUrl;
    this.stateAbbr= stateAbbr;
    this.city = city;


  }
}
