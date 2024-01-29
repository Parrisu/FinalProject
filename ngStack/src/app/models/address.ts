import { City } from './city';

export class Address {
  id: number;
  street: string;
  zipCode: string;
  city: City;

  constructor(
    id: number = 0,
    street: string = '',
    zipCode: string = '',
    city: City = new City()
  ) {
    this.id = id;
    this.street = street;
    this.zipCode = zipCode;
    this.city = city;
  }

  intoJsonBody(): any {
    const data: any = { id: this.id };
    if (this.id !== 0) {
      data.id = this.id;
    }
    if (this.street.replace(/\s/g, '') !== '') {
      data.street = this.street;
    }
    if (this.zipCode.replace(/\s/g, '') !== '') {
      data.zipCode = this.zipCode;
    }
    return data;
  }
}
