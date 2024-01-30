import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Address } from '../models/address';
import { environment } from '../../environments/environment';
import { Observable, catchError, map, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AddressService {
  constructor(private http: HttpClient) {}

  public validateAddress(address: Address): Observable<Address | null> {
    const endpoint = `https://addressvalidation.googleapis.com/v1:validateAddress?key=${environment.googleApiKey}`;
    const body = {
      address: {
        regionCode: 'US',
        locality: address.city,
        administrativeArea: address.stateAbbreviation,
        postalCode: address.zipCode,
        addressLines: [address.street],
      },
    };
    return this.http.post<any>(endpoint, body).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              `
            AddressService.validateAddress(address: Address): Observable<Address>;
            Error while attempting POST to validate address.
            body: ${JSON.stringify(body)}`
            )
        );
      }),
      map((data: any) => {
        const isValid = !data.result.verdict.hasUnconfirmedComponents;
        let result = null;
        if (isValid) {
          const returnedData = data.result.address.postalAddress;
          result = new Address();
          result.zipCode = returnedData.postalCode;
          result.stateAbbreviation = returnedData.administrativeArea;
          result.city = returnedData.locality;
          result.street = returnedData.addressLines[0];
        }
        return result;
      })
    );
  }
}
