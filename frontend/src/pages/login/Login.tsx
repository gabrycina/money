import { Text, View } from "react-native";
import { useDispatch } from "react-redux";
import { Link, useNavigate } from "react-router-native";
import { PrivateRoutes, PublicRoutes } from "../../models";
import { createUser } from "../../redux/slices/user.slice";


export default function Login() {
  const dispatch = useDispatch();
  const navigate = useNavigate();
  
  async function login() {
      try {
      const requestOptions = {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          
        }),
      };

      const res = await fetch(
        "",
        requestOptions
      );

      const data = await res.json();
      dispatch(createUser({ ...data.user, secret: data.secret }));
      navigate(PrivateRoutes.HOME, { replace: true });
  
    } catch (error) {
      console.log(error);
    }
  }

  return (
      <View className="flex-1 items-center justify-center bg-white">
        <Text>Login!</Text>
        <Link to="/home" className="bg-red-600 m-10 px-10 py-2 rounded-md shadow-sm">
          <Text className="text-white">Sign In</Text>
        </Link>
      </View>
  );
}