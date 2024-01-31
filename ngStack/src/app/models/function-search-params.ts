import { Technology } from './technology';

export class FunctionSearchParams {
  searchQuery: string | null;
  cityName: string | null;
  stateAbbr: string | null;
  stack: Technology[];

  constructor(
    searchQuery: string | null = null,
    cityName: string | null = null,
    stateAbbr: string | null = null,
    stack: Technology[] = []
  ) {
    this.searchQuery = searchQuery;
    this.cityName = cityName;
    this.stateAbbr = stateAbbr;
    this.stack = stack;
  }

  intoJsObject(): any {
    const body: any = {};
    if (this.isValidString(this.searchQuery)) {
      body.searchQuery = this.searchQuery;
    }
    if (this.isValidString(this.cityName)) {
      body.cityName = this.cityName;
    }
    if (this.isValidString(this.stateAbbr)) {
      body.stateAbbr = this.stateAbbr;
    }
    if (0 < this.stack.length) {
      body.stack = this.stack.toString();
    }
    return body;
  }

  private isValidString(field: string | null): boolean {
    return field !== null && !/\s*/.test(field);
  }
}
