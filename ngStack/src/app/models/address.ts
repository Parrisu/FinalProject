export class Address {
  public id: number;
  public street: string;
  public zipCode: string;
  public stateAbbreviation: string;
  public city: string;

  constructor(
    id: number = 0,
    street: string = '',
    zipCode: string = '',
    stateAbbreviation: string = '',
    city: string = ''
  ) {
    this.id = id;
    this.street = street;
    this.zipCode = zipCode;
    this.stateAbbreviation = stateAbbreviation;
    this.city = city;
  }

  intoJsObject(): any {
    const data: any = { id: this.id };

    if (this.street.replace(/\s/g, '') !== '') {
      data.street = this.street;
    }

    if (this.zipCode.replace(/\s/g, '') !== '') {
      data.zipCode = this.zipCode;
    }

    if (this.stateAbbreviation.replace(/\s/g, '') !== '') {
      data.stateAbbreviation = this.stateAbbreviation;
    }

    if (this.city.replace(/\s/g, '') !== '') {
      data.city = this.city;
    }

    return data;
  }
}
