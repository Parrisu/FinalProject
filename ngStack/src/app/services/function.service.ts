import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { Function } from '../models/function';
import { AuthService } from './auth.service';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class FunctionService {
  baseUrl = `${environment.baseUrl}api/nodes`;

  constructor(private http: HttpClient, private auth: AuthService) {}

  getFunctions(id: number) {
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
                UserService.reactivate(id: number);
                Error while attempting GET to ${endpoint}.
              `)
        );
      })
    );
  }


}
