export class City {
  id: number;
  name: string;
  state: string;

  constructor(id: number = 0, name: string = '', state: string = '') {
    this.id = id;
    this.name = name;
    this.state = state;
  }

  intoJsObject(): any {
    const data: any = { id: this.id };
    if (this.name.replace(/\s/g, '') !== '') {
      data.name = this.name;
    }
    if (this.state.replace(/\s/g, '') !== '') {
      data.state = this.state;
    }
    return data;
  }
}
