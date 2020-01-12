import PharmacyLayout from "layouts/PharmacyLayout";
import AuthLayout from "layouts/AuthLayout";
import CourierLayout from "layouts/CourierLayout";
import OrdersAll from "pages/OrdersAll";
import OrdersToday from "pages/OrdersToday";
import Error404 from "pages/Error404";
import AuthPage from "pages/AuthPage";

const routes = [
  { path: "/", redirect: "/auth" },
  {
    path: "/auth",
    component: AuthLayout,
    children: [{ path: "/", name: "AuthPage", component: AuthPage }]
  },
  {
    path: "/pharmacy",
    component: PharmacyLayout,
    children: [
      { path: "", redirect: "orders_today" },
      { path: "orders_today", name: "pharmaToday", component: OrdersToday },
      { path: "orders_all", name: "pharmaAll", component: OrdersAll }
    ]
  },
  {
    path: "/courier",
    component: CourierLayout,
    children: [
      { path: "", redirect: "orders_today" },
      { path: "orders_today", name: "courToday", component: OrdersToday },
      { path: "orders_all", name: "courAll", component: OrdersAll }
    ]
  }
];

// Always leave this as last one
if (process.env.MODE !== "ssr") {
  routes.push({
    path: "*",
    component: Error404
  });
}

export default routes;
