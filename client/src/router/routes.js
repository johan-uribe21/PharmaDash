import PharmacyLayout from "layouts/PharmacyLayout";
import CourierLayout from "layouts/CourierLayout";
import OrdersAll from "pages/OrdersAll";
import OrdersToday from "pages/OrdersToday";
import Error404 from "pages/Error404";

const routes = [
  { path: "/", redirect: "/pharmacy" },
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
