import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import { Observable, catchError, throwError } from 'rxjs';
import { Nodes } from '../models/node';
import { AuthService } from './auth.service';
import { User } from '../models/user';
import { SearchParams } from '../models/search-params';

@Injectable({
  providedIn: 'root',
})
export class NodeService {
  private baseUrl = environment.baseUrl; // adjust port to match server
  private url = this.baseUrl + 'api/nodes';

  constructor(private http: HttpClient, private auth: AuthService) {}

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  public getAllUsersInNode(nodeId: number): Observable<User[]> {
    const endpoint = `${this.url}/${nodeId}/members`;
    return this.http.get<User[]>(endpoint).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
            NodeService.getAllUsersInNode(nodeId: number): Observable<User[]>;
            Error while getting users in a node ${err}
            `)
        );
      })
    );
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

  public findById(id: number): Observable<Nodes> {
    return this.http.get<Nodes>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'NodesService.findByName(): error retrieving nodes: ' + err
            )
        );
      })
    );
  }

  public create(newNode: Nodes): Observable<Nodes> {
    newNode.name;
    newNode.description;
    newNode.stateAbbreviation;
    newNode.city;
    newNode.imageUrl;
    newNode.openToPublic = true;
    return this.http.post<Nodes>(this.url, newNode, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('Nodes.Create(): error creating new node: ' + err)
        );
      })
    );
  }

  public joinNode(nodeId: number): Observable<User[]> {
    const endpoint = this.url + '/' + nodeId + '/members';
    return this.http.post<User[]>(endpoint, {}, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('NodesService.join(): error joining node: ' + err)
        );
      })
    );
  }

  public searchNodes(params: SearchParams): Observable<Nodes[]> {
    const endpoint = this.url;
    const httpParams = new HttpParams({ fromObject: params.intoJsObject() });
    return this.http.get<Nodes[]>(endpoint, { params: httpParams }).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
              NodeService.searchNodes(params: NodeSearchParams): Observable<Nodes[]>;
              Error while attempting get to endpoint ${endpoint} with params ${JSON.stringify(
              params.intoJsObject()
            )}
          `)
        );
      })
    );
  }

  public updateNode(nodeId: number, node: Nodes): Observable<Nodes> {
    const endpoint = `${this.url}/${nodeId}`;
    const options = this.getHttpOptions();
    return this.http.put<Nodes>(endpoint, node, options).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
              NodeService.updateNode(nodeId: number, node: Nodes): Observable<Nodes>;
              Error while attempting get to endpoint ${endpoint} with body ${JSON.stringify(
              node
            )}`)
        );
      })
    );
  }

  public deleteNode(nodeId: number): Observable<void> {
    const endpoint = `${this.url}/${nodeId}`;
    const options = this.getHttpOptions();
    return this.http.delete<void>(endpoint, options).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
              NodeService.deleteNode(nodeId: number): Observable<void>;
              Error while attempting DELETE to endpoint ${endpoint}`)
        );
      })
    );
  }

  public leaveNode(nodeId: number): Observable<void> {
    const endpoint = `${this.url}/${nodeId}/members`;
    const options = this.getHttpOptions();
    return this.http.delete<void>(endpoint, options).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(`
              NodeService.leaveNode(nodeId: number): Observable<void>;
              Error while attempting DELETE to endpoint ${endpoint}`)
        );
      })
    );
  }
}
