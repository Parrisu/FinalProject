import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { City } from '../models/city';

@Injectable({
  providedIn: 'root',
})
export class CityService {
  baseUrl = `${environment.baseUrl}api/cities`;

  constructor(private http: HttpClient) {}

  public getAll(): Observable<City[]> {
    const endpoint = this.baseUrl;
    return this.http.get<City[]>(endpoint).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
            CityService.getAll(): Observable<City[]>;
            Error while attempting get to ${this.baseUrl}.
            `)
        );
      })
    );
  }
}
