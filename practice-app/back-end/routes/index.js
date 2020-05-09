import { Router } from "express";
import testRoute from "./test";

const indexRoute = Router();

indexRoute.use("/test", testRoute);

export default indexRoute;
