import { Text, View } from "react-native";
import { Link } from "react-router-native";

export default function Login() {
  return (
      <View className="flex-1 items-center justify-center bg-white">
        <Text>Login!</Text>
        <Link to="/home" className="bg-red-600 m-10 px-10 py-2 rounded-md shadow-sm">
          <Text className="text-white">Sign In</Text>
        </Link>
      </View>
  );
}