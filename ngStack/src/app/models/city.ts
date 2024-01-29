export class City {
  id: number;
  name: string;
  state: string;

  constructor(id: number = 0, name: string = '', state: string = '') {
    this.id = id;
    this.name = name;
    this.state = state;
  }
}
