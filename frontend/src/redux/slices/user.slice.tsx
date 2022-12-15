import { UserInfoEmptyState } from "../../models";
import { createSlice } from "@reduxjs/toolkit";

export const UserKey = "user";

export const userSlice = createSlice({
  name: "user", //Name that represents the slice
  initialState: UserInfoEmptyState, //Default value
  reducers: {
    createUser: (state, action) => {
      return action.payload;
    },
    modifyUser: (state, action) => {
      const result = { ...state, ...action.payload };
      return result
    },
    resetUser: () => {
      return UserInfoEmptyState;
    },
  },
});

// Action creators are generated for each case reducer function
export const { createUser, resetUser } = userSlice.actions;

export default userSlice.reducer;
