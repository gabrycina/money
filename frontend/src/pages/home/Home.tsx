import { Text, View } from "react-native";
import { Link } from "react-router-native";

export default function Home() {
  return (
      <View className="flex-1 items-center justify-center bg-white">
        <Text>Home!</Text>
        <Link to="/" className="bg-red-600 m-10 px-10 py-2 rounded-md shadow-sm">
          <Text className="text-white">Sign Out</Text>
        </Link>
      </View>
  );
}