import AsyncStorage from '@react-native-async-storage/async-storage';
import { UserInfoEmptyState } from '../models';

export const persistLocalStorage = async <T,>(key: string, value: T) => {
  await AsyncStorage.setItem(key, JSON.stringify({ ...value }));
};

export const clearLocalStorage = async (key: string) => {
  await AsyncStorage.removeItem(key);
};

export const initialLocalStorage = async () => {
  return await AsyncStorage.getItem("user")
    ? JSON.parse(await AsyncStorage.getItem("user") as string)
    : UserInfoEmptyState
}
