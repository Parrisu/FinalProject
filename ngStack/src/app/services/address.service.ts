import { Address } from './../models/address';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import { Observable, catchError, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AddressService {
  baseUrl = `${environment.baseUrl}/cities`;
  constructor(private http: HttpClient) {}

  public createAddress(address: Address, cityId: number): Observable<Address> {
    const endpoint = `${this.baseUrl}/${cityId}/addresses`;
    const body = address.intoJsonBody();
    return this.http.post<Address>(endpoint, body).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
            AddressService.createAddress(address: Address, cityId: number): Observable<Address>;
            Error while attempting POST to '${this.baseUrl}/${cityId}/addresses'.
            With body ${body}.
          `)
        );
      })
    );
  }
}
