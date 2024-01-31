import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import { Observable, catchError, throwError } from 'rxjs';
import { Technology } from '../models/technology';

@Injectable({
  providedIn: 'root'
})
export class TechnologyService {

  private baseUrl = environment.baseUrl; // adjust port to match server
  private url = this.baseUrl + 'api/technologies';
  constructor(
    private http: HttpClient,



    ) { }


    showAll(): Observable<Technology[]>{
    return this.http.get<Technology[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('TechnologyService.ShowAll(): error retrieving technologies: ' + err)
        );
      })
    );
  }
}
