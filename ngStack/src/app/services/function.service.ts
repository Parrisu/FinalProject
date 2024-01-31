import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { Function } from '../models/function';
import { AuthService } from './auth.service';
import { environment } from '../../environments/environment';
import { SearchParams } from '../models/search-params';

@Injectable({
  providedIn: 'root',
})
export class FunctionService {
  baseUrl = `${environment.baseUrl}api/nodes`;

  constructor(private http: HttpClient, private auth: AuthService) {}

  getFunctions(id: number): Observable<Function[]> {
    const endpoint = `${this.baseUrl}/${id}/function`;
    const credentials = this.auth.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest',
      }),
    };

    return this.http.get<Function[]>(endpoint, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
                FunctionService.getFunctions(id: number): Observable<Function[]>;
                Error while attempting GET to ${endpoint}.
              `)
        );
      })
    );
  }

  searchFunctions(params: SearchParams): Observable<Function[]> {
    const endpoint = `${environment.baseUrl}api/functions`;
    const httpParams = new HttpParams({ fromObject: params.intoJsObject() });
    const credentials = this.auth.getCredentials();
    const httpOptions = {
      params: httpParams,
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest',
      }),
    };
    return this.http.get<Function[]>(endpoint, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
                FunctionService.searchFunctions(params: FunctionSearchParams): Observable<Function[]>;
                Error while attempting GET to ${endpoint}.
              `)
        );
      })
    );
  }
}
