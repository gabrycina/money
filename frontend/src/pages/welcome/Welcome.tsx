import { Text, View } from "react-native";
import { Link } from "react-router-native";

export default function Welcome() {
  return (
      <View className="flex-1 items-center justify-center bg-white">
        <Text>Welcome!</Text>
        <Link to="/login" className="bg-red-600 m-10 px-10 py-2 rounded-md shadow-sm">
          <Text className="text-white">Login</Text>
        </Link>
      </View>
  );
}