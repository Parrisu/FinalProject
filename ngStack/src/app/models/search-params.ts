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
    if (!/\s*/.test(this.searchQuery)) {
      body.searchQuery = this.searchQuery;
    }
    if (!/\s*/.test(this.cityName)) {
      body.cityName = this.cityName;
    }
    if (!/\s*/.test(this.stateAbbr)) {
      body.stateAbbr = this.stateAbbr;
    }
    if (0 < this.stack.length) {
      body.stack = this.stack.toString();
    }
    return body;
  }
}
