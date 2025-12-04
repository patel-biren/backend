import { Multer as MulterType } from "multer";

declare global {
  namespace Express {
    interface Multer extends MulterType {}
  }
}

export {};
