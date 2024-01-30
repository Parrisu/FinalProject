import { Address } from './../models/address';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from '../../environments/environment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  baseUrl = `${environment.baseUrl}api/users`;

  constructor(private http: HttpClient, private auth: AuthService) {}

  public setUserAddress(userId: number, address: Address): Observable<Address> {
    const endpoint = `${this.baseUrl}/${userId}/address`;
    const credentials = this.auth.getCredentials();
    const body = address.intoJsObject();
    return this.http
      .put<Address>(endpoint, body, {
        headers: new HttpHeaders({
          Authorization: `Basic ${credentials}`,
          'X-Requested-With': 'XMLHttpRequest',
        }),
      })
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(`
                UserService.setUserAddress(userId: number, address: Address): Observable<Address>;
                Error while attempting PUT to ${endpoint}.
                With body ${JSON.stringify(body)}
              `)
          );
        })
      );
  }
}
