import { Technology } from './technology';

export class SearchParams {
  searchQuery: string;
  cityName: string;
  stateAbbr: string;
  stack: Technology[];

  constructor(
    searchQuery: string = '',
    cityName: string = '',
    stateAbbr: string = '',
    stack: Technology[] = []
  ) {
    this.searchQuery = searchQuery;
    this.cityName = cityName;
    this.stateAbbr = stateAbbr;
    this.stack = stack;
  }

  intoJsObject(): any {
    const body: any = {};
    if (this.searchQuery.replace(/\s/, '') != '') {
      body.searchQuery = this.searchQuery;
    }
    if (this.cityName.replace(/\s/, '') != '') {
      body.cityName = this.cityName;
    }
    if (this.stateAbbr.replace(/\s/, '') != '') {
      body.stateAbbr = this.stateAbbr;
    }
    if (0 < this.stack.length) {
      const ids = this.stack.map((tech)=>tech.id);
      body.stack = ids.toString();
    }
    return body;
  }
}
