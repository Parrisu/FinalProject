import { User } from "./user";
import { Nodes } from "./node";

export class Function {
  id: number;
  name: string;
  cancelled: boolean;
  enabled: boolean;
  date: string;
  startTime: string;
  endTime: string;
  cap: number;
  imgUrl: string;
  creator: User;
  node: Nodes;

  constructor(
    id: number = 0,
    name: string = "",
    cancelled: boolean = false,
    enabled: boolean = true,
    date: string = "",
    startTime: string = "",
    endTime: string = "",
    cap: number = 0,
    imgUrl: string = "",
    creator: User = new User(),
    node: Nodes = new Nodes(),
  ) {
    this.id = id;
    this.name = name;
    this.cancelled = cancelled;
    this.enabled = enabled;
    this.date = date;
    this.startTime = startTime;
    this.endTime = endTime;
    this.cap = cap;
    this.imgUrl = imgUrl;
    this.creator = creator;
    this.node = node;
  }

}
