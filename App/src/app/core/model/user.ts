export interface User {
  id: number;
  email: string;
  password: string;
  confirmPassword: string;
  fullName: string;
  phoneNumber: string;
  isActive: boolean;
  token: string;
  dateOfBirth: Date;
  address: string;
  gender: number;
}
