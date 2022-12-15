import { UserInfo, UserInfoEmptyState } from "../../models";
import { clearLocalStorage, persistLocalStorage, initialLocalStorage } from "../../utilities";
import { createSlice } from "@reduxjs/toolkit";
import AsyncStorage from "@react-native-async-storage/async-storage";

export const UserKey = "user";

export const userSlice = createSlice({
  name: "user", //Name that represents the slice
  initialState: UserInfoEmptyState, //Default value
  reducers: {
    createUser: (state, action) => {
      persistLocalStorage<UserInfo>(UserKey, action.payload);
      return action.payload;
    },
    resetUser: () => {
      clearLocalStorage(UserKey);
      return UserInfoEmptyState;
    },
  },
});

// Action creators are generated for each case reducer function
export const { createUser, resetUser } = userSlice.actions;

export default userSlice.reducer;
