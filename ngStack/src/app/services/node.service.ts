import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import { AuthService } from './auth.service';
import { Observable, catchError, throwError } from 'rxjs';
import { Nodes } from '../models/node';

@Injectable({
  providedIn: 'root',
})
export class NodeService {
  private baseUrl = environment.baseUrl; // adjust port to match server
  private url = this.baseUrl + 'api/nodes';
  constructor(
    private http: HttpClient,
    private datePipe: DatePipe,
    private auth: AuthService
  ) {}

  public showAll(): Observable<Nodes[]> {
    return this.http.get<Nodes[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'NodesService.ShowAll(): error retrieving technologies: ' + err
            )
        );
      })
    );
  }

  public findByName(name: string): Observable<Nodes[]> {
    return this.http.get<Nodes[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'NodesService.findByName(): error retrieving technologies: ' + err
            )
        );
      })
    );
  }
}
