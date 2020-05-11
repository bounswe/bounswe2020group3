import { Router } from "express";
import testRoute from "./test";
import usersRoute from "./users";

const indexRoute = Router();

indexRoute.use("/test", testRoute);
indexRoute.use("/users", usersRoute);

export default indexRoute;