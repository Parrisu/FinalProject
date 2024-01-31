import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import { Observable, catchError, throwError } from 'rxjs';
import { Nodes } from '../models/node';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root',
})
export class NodeService {

  private baseUrl = environment.baseUrl; // adjust port to match server
  private url = this.baseUrl + 'api/nodes';

  constructor(
    private http: HttpClient,
    private auth: AuthService
    ) {}

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

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


  public create(newNode: Nodes): Observable<Nodes> {
    newNode.name = '';
    newNode.description = '';
    newNode.stateAbbrev = '';
    newNode.city = '';
    newNode.imageUrl = '';
    newNode.openToPublic = true;
    return this.http.post<Nodes>(this.url, newNode,  this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('Nodes.Create(): error creating new node: ' + err)
        );
      })
    );
  }

}
