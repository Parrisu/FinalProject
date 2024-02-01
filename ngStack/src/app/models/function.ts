import { User } from './user';
import { Nodes } from './node';
import { Address } from './address';

export class Function {
  id: number;
  name: string;
  cancelled: boolean;
  enabled: boolean;
  date: string;
  start: string;
  end: string;
  cap: number;
  imgUrl: string;
  user: User;
  node: Nodes;
  address: Address;
  nodeId: number;
  nodeName: string;

  constructor(
    id: number = 0,
    name: string = '',
    cancelled: boolean = false,
    enabled: boolean = true,
    date: string = '',
    start: string = '',
    end: string = '',
    cap: number = 0,
    imgUrl: string = '',
    user: User = new User(),
    node: Nodes = new Nodes(),
    address: Address = new Address(),
    nodeId: number = 0,
    nodeName: string = ''
  ) {
    this.id = id;
    this.name = name;
    this.cancelled = cancelled;
    this.enabled = enabled;
    this.date = date;
    this.start = start;
    this.end = end;
    this.cap = cap;
    this.imgUrl = imgUrl;
    this.user = user;
    this.node = node;
    this.address = address;
    this.nodeId = nodeId;
    this.nodeName = nodeName;
  }
}
