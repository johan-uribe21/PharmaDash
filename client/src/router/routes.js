import PharmacyLayout from "layouts/PharmacyLayout";
import AuthLayout from "layouts/AuthLayout";
import CourierLayout from "layouts/CourierLayout";
import PharmaOrdersAll from "pages/PharmaOrdersAll";
import PharmaOrdersToday from "pages/PharmaOrdersToday";
import CourierOrdersAll from "pages/CourierOrdersAll";
import CourierOrdersToday from "pages/CourierOrdersToday";
import PharmaPatients from "pages/PharmaPatients";
import PharmaCouriers from "pages/PharmaCouriers";
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
      {
        path: "orders_today",
        name: "pharmaToday",
        component: PharmaOrdersToday
      },
      {
        path: "patients",
        name: "patients",
        component: PharmaPatients
      },
      {
        path: "couriers",
        name: "couriers",
        component: PharmaCouriers
      },
      { path: "orders_all", name: "pharmaAll", component: PharmaOrdersAll }
    ]
  },
  {
    path: "/courier",
    component: CourierLayout,
    children: [
      { path: "", redirect: "orders_today" },
      {
        path: "orders_today",
        name: "courierToday",
        component: CourierOrdersToday
      },
      { path: "orders_all", name: "courierAll", component: CourierOrdersAll }
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
