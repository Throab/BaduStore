import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';

export class BaseService {
  public routerPrefix: string;
  constructor(
    public http: HttpClient,
    public prefix: string,
  ) {
    this.routerPrefix = environment.hostApi + '/api/' + prefix;
  }
  getAll() {
    return this.http.get(this.routerPrefix);
  }
  post(entity: any) {
    return this.http.post(this.routerPrefix, entity);
  }
}
