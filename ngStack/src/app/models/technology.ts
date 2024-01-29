export class Technology {
  id: number;
  name: string;
  badgeUrl: string;
  description: string;

  constructor(
    id: number = 0,
    name: string = '',
    badgeUrl: string = '',
    description: string = '',
  ) {
    this.id = id;
    this.name = name;
    this.badgeUrl = badgeUrl;
    this.description = description;
  }
}
